use std::collections::HashSet;
use std::fmt;

#[derive(PartialEq)]
enum PickStatus {
    Completed,
    Marked,
    Missed,
}

struct Board {
    unmarked_numbers: HashSet<i32>,
    rows: Vec<Vec<i32>>,
    columns: Vec<Vec<i32>>,
    completed: bool,
}

impl Board {
    fn from_lines(lines: Vec<Vec<i32>>) -> Board {
        let mut cols = Vec::new();
        let mut unmarked_numbers = HashSet::new();
        for _ in lines[0].iter() {
            cols.push(Vec::new());
        }

        for line in lines.iter() {
            for (i, v) in line.iter().enumerate() {
                cols[i].push(*v);
                unmarked_numbers.insert(*v);
            }
        }

        Board {
            unmarked_numbers,
            rows: lines,
            columns: cols,
            completed: false,
        }
    }

    fn mark(&mut self, pick: i32) -> PickStatus {
        if !self.unmarked_numbers.remove(&pick) {
            return PickStatus::Missed;
        }

        for row in self.rows.iter_mut() {
            if let Some(i) = row.iter().position(|&x| x == pick) {
                if row.len() == 1 {
                    // It would be the last item;
                    self.completed = true;
                    return PickStatus::Completed;
                }
                row.swap_remove(i);
                break;
            }
        }

        for col in self.columns.iter_mut() {
            if let Some(i) = col.iter().position(|&x| x == pick) {
                if col.len() == 1 {
                    // It would be the last item;
                    self.completed = true;
                    return PickStatus::Completed;
                }
                col.swap_remove(i);
                break;
            }
        }

        PickStatus::Marked
    }

    fn score(&self, pick: i32) -> i32 {
        self.unmarked_numbers.iter().sum::<i32>() * pick
    }
}

impl fmt::Debug for Board {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "\n").ok();
        for line in self.rows.iter() {
            write!(f, "|").ok();
            for c in line.iter() {
                let marked = !self.unmarked_numbers.contains(c);
                let mut prefix: &str = "";

                if marked {
                    prefix = "*";
                }
                write!(f, "{}{} ", prefix, c).ok();
            }
            write!(f, "|\n").ok();
        }
        write!(f, "\n")
    }
}

fn parse_picks_and_boards(filename: &str) -> (Vec<i32>, Vec<Board>) {
    let lines: Vec<_> = super::helpers::read_lines(filename)
        .collect::<Result<_, _>>()
        .unwrap();

    let picks: Vec<i32> = lines
        .first()
        .unwrap()
        .split(",")
        .map(|l| l.parse::<i32>().unwrap())
        .collect();

    let mut current: Vec<Vec<i32>> = Vec::new();

    let mut boards: Vec<Board> = Vec::new();

    for line in lines.iter().skip(1) {
        if line.trim().is_empty() {
            continue;
        }

        let tokens: Vec<i32> = line
            .split_whitespace()
            .map(|c| c.parse::<i32>().unwrap())
            .collect();

        current.push(tokens);

        if current.len() == 5 {
            let board = Board::from_lines(current);
            boards.push(board);
            current = Vec::new();
        }
    }

    if current.len() == 5 {
        let board = Board::from_lines(current);
        boards.push(board);
    }

    (picks, boards)
}

pub fn first() {
    let filename = "data/day04.txt";

    let (picks, mut boards) = parse_picks_and_boards(filename);

    for pick in picks {
        for board in boards.iter_mut() {
            if board.mark(pick) != PickStatus::Completed {
                continue;
            }

            println!("Day 04 part 1: {}", board.score(pick));
            return;
        }
    }
}

pub fn second() {
    let filename = "data/day04.txt";
    let (picks, mut boards) = parse_picks_and_boards(filename);

    let num_boards = boards.len();
    let mut completed = 0;

    for pick in picks {
        for board in boards.iter_mut() {
            if board.completed {
                continue;
            }
            if board.mark(pick) == PickStatus::Completed {
                completed += 1;
                if num_boards == completed {
                    println!("Day 04 part 2: {}", board.score(pick));
                    return;
                }
            }
        }
    }
}
