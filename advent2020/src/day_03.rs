fn read_maze(filename: &str) -> Vec<Vec<char>> {
    let lines = super::helpers::read_lines(filename);
    let line_str: Vec<String> = lines.into_iter().map(|x| x.unwrap()).collect();
    line_str.into_iter().map(|x| x.chars().collect()).collect()
}

fn count_trees(maze: &Vec<Vec<char>>, dx: usize, dy: usize) -> i64 {
    let mut x = 0;
    let mut y = 0;
    let mut count = 0;
    let height = maze.len();
    let width = maze[0].len();

    while y < height {
        y += dy;

        if y >= height {
            break;
        }
        x = (x + dx) % width;

        if maze[y][x] == '#' {
            count += 1;
        }
    }

    count
}

pub fn first() {
    let filename = "day03-01.txt";
    let maze = read_maze(filename);
    let dx = 3;
    let dy = 1;

    println!("Day 3 - 1: {}", count_trees(&maze, dx, dy));
}

pub fn second() {
    let filename = "day03-01.txt";
    let maze = read_maze(filename);
    let pairs = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)];

    let count: i64 = pairs
        .iter()
        .map(|(dx, dy)| count_trees(&maze, *dx, *dy))
        .product();

    println!("Day 3 - 1: {}", count);
}
