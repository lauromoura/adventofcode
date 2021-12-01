use regex::Regex;

pub fn first() {
    let filename = "day02-01.txt";
    let lines = super::helpers::read_lines(filename);
    println!(
        "Day 2 - 1: {}",
        lines
            .filter(|i| check_password_mk1(i.as_ref().unwrap()))
            .count()
    );
}

fn parse_line(line: &str) -> regex::Captures {
    let re = Regex::new(r"(\d+)-(\d+) ([a-z]): ([a-z]+)").unwrap();
    re.captures(line).unwrap()
}

fn check_password_mk1(line: &str) -> bool {
    // let tokens : Vec<&str> = line.split(" ").into_iter().collect();
    let cap = parse_line(line);
    let min = cap[1].parse::<usize>().unwrap();
    let max = cap[2].parse::<usize>().unwrap();
    let letter = cap[3].chars().next().unwrap();
    let passwd = &cap[4];

    let count = passwd.chars().into_iter().filter(|&i| i == letter).count();

    min <= count && count <= max
}

fn check_password_mk2(line: &str) -> bool {
    // let tokens : Vec<&str> = line.split(" ").into_iter().collect();
    let cap = parse_line(line);
    let min = cap[1].parse::<usize>().unwrap();
    let max = cap[2].parse::<usize>().unwrap();
    let letter = cap[3].chars().next().unwrap();
    let passwd = &cap[4];

    // Ignore unicode...
    let first = passwd.as_bytes()[min - 1] as char;
    let second = passwd.as_bytes()[max - 1] as char;
    if first == letter {
        second != letter
    } else {
        second == letter
    }
}

pub fn second() {
    let filename = "day02-01.txt";
    let lines = super::helpers::read_lines(filename);
    println!(
        "Day 2 - 1: {}",
        lines
            .filter(|i| check_password_mk2(i.as_ref().unwrap()))
            .count()
    );
}
