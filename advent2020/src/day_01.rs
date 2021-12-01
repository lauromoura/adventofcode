use std::collections::HashSet;

pub fn first() {
    let filename = "day01-01.txt";

    let lines = super::helpers::read_lines(filename);
    let mut seen = HashSet::new();
    for line in lines {
        let value = line.unwrap().parse::<i32>().unwrap();
        let candidate = 2020 - value;
        if seen.contains(&candidate) {
            println!("Day 1 - 1: {}", candidate * value);
            break;
        } else {
            seen.insert(value);
        }
    }
}

pub fn second() {
    let filename = "day01-01.txt";

    let lines = super::helpers::read_lines(filename);
    let numbers: Vec<i32> = lines
        .into_iter()
        .map(|x| x.unwrap().parse::<i32>().unwrap())
        .collect();
    let set: HashSet<&i32> = numbers.iter().collect();

    for (pos, x) in numbers.iter().enumerate() {
        for another in &numbers[(pos + 1)..] {
            let candidate = 2020 - x - another;
            if set.contains(&candidate) {
                println!("Day 1 - 2: {}", candidate * x * another);
                return;
            }
        }
    }
}
