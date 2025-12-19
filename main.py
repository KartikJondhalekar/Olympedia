import pymysql
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
from datetime import date
from tabulate import tabulate


def db_connect(username, password):
    try:
        connection = pymysql.connect(
            host = "localhost",
            user = username,
            password = password,
            db = "CS5200_Project"
        )
        return connection
    except pymysql.MySQLError as e:
        print("Error connecting to the database:", e)
        return None

def call_stored_procedure(cursor, procedure_name, parameters=()):
    try:
        cursor.callproc(procedure_name, parameters)
        results = cursor.fetchall()
        column_names = [desc[0] for desc in cursor.description]
        return column_names, results
    except pymysql.MySQLError as e:
        print(f"Error calling stored procedure {procedure_name}: {e}")
        return None, None

def sign_up(cursor, connection):
    print("\nSign Up:")
    username = input("Enter your username: ").strip()
    password = input("Enter your password: ").strip()

    if username and password:
        try:
            cursor.execute("CALL add_user(%s, %s, 'USER');", (username, password))
            connection.commit()
            print(f"User '{username}' registered successfully!")
        except pymysql.MySQLError as e:
            print(f"Error during sign-up: {e}")
    else:
        print("Username and password cannot be empty.")

def authenticate_user(cursor):
    try:
        print("\nSign In:")
        username = input("Enter your username: ").strip()
        password = input("Enter your password: ").strip()

        if username and password:
            try:
                cursor.execute("SET @user_role = NULL;")
                cursor.execute("CALL authenticate_user(%s, %s, @user_role);", (username, password))
                cursor.execute("SELECT @user_role;")
                result = cursor.fetchone()

                if result and result[0] in ("ADMIN", "USER"):
                    print(f"Welcome, {username}! You are logged in as {result[0]}.")
                    return result[0]  # Return the user's role
                else:
                    print("Invalid login credentials.")
            except pymysql.MySQLError as e:
                print(f"Error during authentication: {e}")
        else:
            print("Username and password cannot be empty.")
        return None

    except pymysql.MySQLError as e:
        print("Error:", e)

def display_options(cursor, procedure_name):
    column_names, results = call_stored_procedure(cursor, procedure_name)
    if results:
        print("\nOptions:")
        print(tabulate(results, headers=column_names, tablefmt="grid"))
        while True:
            choice = input("Enter your choice (by ID or valid field): ").strip()
            if any(str(choice) == str(row[0]) for row in results):
                return choice
            else:
                print("Invalid choice. Please try again.")
    else:
        print("No options available.")
        return None

def plot_medal_distribution_by_country(cursor, year):
    column_names, results = call_stored_procedure(cursor, "get_most_medal_winning_countries_by_year", (year,))
    print(results)
    df = pd.DataFrame(results, columns=["Country", "Medal_Type", "Total_Medals"])

    if df.empty:
        print("No data to display.")
        return

    plt.figure(figsize=(8, 6))
    plt.pie(df["Total_Medals"], labels=df["Country"], autopct="%1.1f%%", startangle=140)
    plt.title("Medal Distribution by Country")
    plt.axis("equal")
    plt.show()


def plot_athlete_age_distribution(cursor):
    cursor.execute("SELECT date_of_birth FROM athlete WHERE date_of_birth IS NOT NULL")
    results = cursor.fetchall()
    today = date.today()

    if not results:
        print("No data to display.")
        return

    ages = [(today.year - dob.year - ((today.month, today.day) < (dob.month, dob.day))) for (dob,) in results]

    df = pd.DataFrame(ages, columns=["Age"])
    plt.figure(figsize=(8, 6))
    sns.histplot(df["Age"], bins=20, kde=True)
    plt.title("Distribution of Athlete Ages")
    plt.xlabel("Age (Years)")
    plt.ylabel("Frequency")
    plt.show()

def plot_height_vs_weight(cursor):
    cursor.execute("SELECT height, weight FROM athlete WHERE height IS NOT NULL AND weight IS NOT NULL")
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Height", "Weight"])

    if df.empty:
        print("No data to display.")
        return

    plt.figure(figsize=(8, 6))
    sns.scatterplot(data=df, x="Height", y="Weight")
    plt.title("Height vs. Weight of Athletes")
    plt.xlabel("Height (cm)")
    plt.ylabel("Weight (kg)")
    plt.show()

def plot_team_size_distribution(cursor):
    cursor.execute("SELECT no_of_players FROM team WHERE no_of_players IS NOT NULL")
    results = cursor.fetchall()

    if not results:
        print("No data to display.")
        return

    df = pd.DataFrame(results, columns=["Number of Players"])
    plt.figure(figsize=(8, 6))
    sns.histplot(df["Number of Players"], bins=10, kde=True)
    plt.title("Distribution of Team Sizes")
    plt.xlabel("Number of Players")
    plt.ylabel("Frequency")
    plt.show()

def boxplot_athlete_weight_by_gender(cursor):
    cursor.execute("SELECT gender, weight FROM athlete WHERE weight IS NOT NULL")
    results = cursor.fetchall()

    if not results:
        print("No data to display.")
        return

    df = pd.DataFrame(results, columns=["Gender", "Weight"])
    plt.figure(figsize=(8, 6))
    sns.boxplot(x="Gender", y="Weight", data=df)
    plt.title("Athlete Weight Distribution by Gender")
    plt.xlabel("Gender")
    plt.ylabel("Weight (kg)")
    plt.show()

def bargraph_athletes_per_country(cursor):
    cursor.execute("""
        SELECT c.name AS Country, COUNT(a.athlete_id) AS Athlete_Count
        FROM athlete a
        JOIN country c ON a.country_id = c.country_id
        GROUP BY c.name
        ORDER BY Athlete_Count DESC
        LIMIT 15;  -- Top 15 for readability
    """)
    results = cursor.fetchall()

    if not results:
        print("No data to display.")
        return

    df = pd.DataFrame(results, columns=["Country", "Athlete_Count"])
    plt.figure(figsize=(10, 6))
    sns.barplot(data=df, x="Country", y="Athlete_Count")
    plt.xticks(rotation=45, ha='right')
    plt.title("Top 15 Countries by Number of Athletes")
    plt.xlabel("Country")
    plt.ylabel("Number of Athletes")
    plt.tight_layout()
    plt.show()

def visualizations(cursor):
    while True:
        print("\nData Visualizations:")
        print("1. Pie Chart – Medal Distribution by Country")
        print("2. Histogram – Number of Players in Teams")
        print("3. Scatter Plot – Athlete Height vs. Weight")
        print("4. Box Plot – Athlete Weight by Gender")
        print("5. Bar Graph – Number of Athletes per Country")
        print("6. Exit Visualizations")

        choice = input("Choose an option (1-4): ").strip()

        if choice == "1":
            year = input("Enter a year: ")
            plot_medal_distribution_by_country(cursor, year)
        elif choice == "2":
            plot_team_size_distribution(cursor)
        elif choice == "3":
            plot_height_vs_weight(cursor)
        elif choice == "4":
            boxplot_athlete_weight_by_gender(cursor)
        elif choice == "5":
            bargraph_athletes_per_country(cursor)
        elif choice == "6":
            break
        else:
            print("Invalid choice. Please try again.")

def read_operations(cursor):
    while True:
        print("\nChoose an option from the following:")
        print("1. Get all events")
        print("2. Get all sports")
        print("3. Get all athletes")
        print("4. Get all teams")
        print("5. Get teams by sports")
        print("6. Get athletes by sports")
        print("7. Get sport records")
        print("8. Get events by country")
        print("9. Get events by year")
        print("10. Get sports in an Olympic event")
        print("11. Get events by sports")
        print("12. Get most medal-winning countries by year")
        print("13. Get medals won by country in indoor sports")
        print("14. Get medals won by country in outdoor sports")
        print("15. Get broadcast details")
        print("16. Get broadcast details by year")
        print("17. Get broadcast details by event")
        print("18. Get event with highest broadcast viewership")
        print("19. Get athletes win history")
        print("20. Get teams win history")
        print("21. Get athlete ranking")
        print("22. Get number of sports participated by a country per event")
        print("23. Exit Read Operations")

        choice = input("Choose an option (1-23): ").strip()

        if choice == "1":
            column_names, results = call_stored_procedure(cursor, "get_olympic_events")
        elif choice == "2":
            column_names, results = call_stored_procedure(cursor, "get_sports")
        elif choice == "3":
            column_names, results = call_stored_procedure(cursor, "get_athletes")
        elif choice == "4":
            column_names, results = call_stored_procedure(cursor, "get_teams")
        elif choice == "5":
            sport_id = display_options(cursor, "get_sports")
            if sport_id:
                column_names, results = call_stored_procedure(cursor, "get_teams_by_sports", (sport_id,))
        elif choice == "6":
            sport_id = display_options(cursor, "get_sports")
            if sport_id:
                column_names, results = call_stored_procedure(cursor, "get_athletes_by_sports", (sport_id,))
        elif choice == "7":
            sport_id = display_options(cursor, "get_sports")
            if sport_id:
                column_names, results = call_stored_procedure(cursor, "get_sport_records", (sport_id,))
        elif choice == "8":
            country_id = display_options(cursor, "get_countries")
            if country_id:
                column_names, results = call_stored_procedure(cursor, "get_events_by_country", (country_id,))
        elif choice == "9":
            year = int(input("Enter a year value: ").strip())
            column_names, results = call_stored_procedure(cursor, "get_events_by_year", (year,))
        elif choice == "10":
            event_id = display_options(cursor, "get_olympic_events")
            if event_id:
                column_names, results = call_stored_procedure(cursor, "get_sports_in_olympic_events", (event_id,))
        elif choice == "11":
            sport_id = display_options(cursor, "get_sports")
            if sport_id:
                column_names, results = call_stored_procedure(cursor, "get_events_by_sports", (sport_id,))
        elif choice == "12":
            year = int(input("Enter a year value: ").strip())
            column_names, results = call_stored_procedure(cursor, "get_most_medal_winning_countries_by_year", (year,))
        elif choice == "13":
            column_names, results = call_stored_procedure(cursor, "get_medals_won_by_country_in_indoor_sports")
        elif choice == "14":
            column_names, results = call_stored_procedure(cursor, "get_medals_won_by_country_in_outdoor_sports")
        elif choice == "15":
            column_names, results = call_stored_procedure(cursor, "get_broadcast_details")
        elif choice == "16":
            year = int(input("Enter a year value: ").strip())
            column_names, results = call_stored_procedure(cursor, "get_broadcast_details_by_year", (year,))
        elif choice == "17":
            event_id = display_options(cursor, "get_olympic_events")
            if event_id:
                column_names, results = call_stored_procedure(cursor, "get_broadcast_details_by_event", (event_id,))
        elif choice == "18":
            column_names, results = call_stored_procedure(cursor, "get_event_with_highest_broadcast_viewership")
        elif choice == "19":
            column_names, results = call_stored_procedure(cursor, "get_athlete_win_history")
        elif choice == "20":
            column_names, results = call_stored_procedure(cursor, "get_team_win_history")
        elif choice == "21":
            column_names, results = call_stored_procedure(cursor, "get_athletes_ranking")
        elif choice == "22":
            column_names, results = call_stored_procedure(cursor, "get_athletes_ranking")
        elif choice == "23":
            country_id = display_options(cursor, "get_countries")
            if country_id:
                column_names, results = call_stored_procedure(cursor, "get_no_of_sports_participated_by_a_country_per_event",
                                                              (country_id,))
        elif choice == "24":
            print("Exiting Read Operations.")
            break
        else:
            print("Invalid choice. Please select a valid option.")
            continue

        # Display results
        if results:
            print("\nResults:")
            print(tabulate(results, headers=column_names, tablefmt="grid"))
        else:
            print("No results found.")

def run_app():
    connection = None

    while not connection:
        try:
            user = input("Enter your DB username: ")
            password = input("Enter your DB password: ")
            connection = db_connect(user, password)
            if not connection:
                print("Invalid credentials. Please try again.\n")
        except Exception as e:
            print("Error:", e)
            return

    print("\nConnection established successfully.")
    keep_running = True
    logged_in = False
    user_role = None

    try:
        while keep_running:
            cursor = connection.cursor()

            if not logged_in:
                print("\nMain Menu:")
                print("1. Sign Up")
                print("2. Sign In")
                print("3. Exit")

                choice = input("Choose an option (1-3): ")

                if choice == "1":
                    sign_up(cursor, connection)
                elif choice == "2":
                    user_role = authenticate_user(cursor)
                    if user_role:
                        logged_in = True
                elif choice == "3":
                    print("Exiting the application.")
                    keep_running = False
                else:
                    print("Invalid choice. Please choose 1, 2, or 3.")

            else:
                if user_role == "USER":
                    print("1. Use Read Operations")
                    print("2. Visualizations")
                    print("3. Logout")

                    choice = input("Choose an option (1-3): ")
                    if choice == "1":
                        read_operations(cursor)
                    elif choice == "2":
                        visualizations(cursor)
                    elif choice == "3":
                        logged_in = False
                else:
                    print("Admin functionality can be added here.")
            cursor.close()

    except Exception as e:
        print(f"Error: {e}")
    finally:
        if connection:
            connection.close()
        print("Connection closed.")


if __name__ == "__main__":
    run_app()
