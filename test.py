import requests
from bs4 import BeautifulSoup

def decode_secret_message(google_doc_url):
    response = requests.get(google_doc_url)
    soup = BeautifulSoup(response.text, 'html.parser')

    rows = soup.find_all('tr')
    points = []
    max_x, max_y = 0, 0

    for row in rows[1:]:
        cells = row.find_all('td')
        if len(cells) != 3:
            continue
        x = int(cells[0].text.strip())
        char = cells[1].text.strip()
        y = int(cells[2].text.strip())

        points.append((x, y, char))
        max_x = max(max_x, x)
        max_y = max(max_y, y)

    grid = [[' ' for _ in range(max_x + 1)] for _ in range(max_y + 1)]

    for x, y, char in points:
        flipped_y = max_y - y
        grid[flipped_y][x] = char

    for row in grid:
        print(''.join(row))

def main():
    url = "https://docs.google.com/document/d/e/2PACX-1vQGUck9HIFCyezsrBSnmENk5ieJuYwpt7YHYEzeNJkIb9OSDdx-ov2nRNReKQyey-cwJOoEKUhLmN9z/pub"
    decode_secret_message(url)

if __name__ == "__main__":
    main()
