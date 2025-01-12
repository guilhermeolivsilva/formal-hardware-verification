"""Draft to read CSV from stdin in a structured manner."""


import sys


def read_csv(path: str) -> list[dict[str, str]]:
    data = []

    with open(path, "r") as file:
        first_line = True

        for line in file:
            entry = line.replace("\n", "").split(",")

            if first_line:
                columns_names = entry
                first_line = False

            else:
                data.append(dict(zip(columns_names, entry)))

    return data


def main():
    print(read_csv(sys.argv[1]))


if __name__ == "__main__":
    main()
