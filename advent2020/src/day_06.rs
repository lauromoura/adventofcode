use std::collections::HashSet;

pub fn first() {
    let filename = "day06-01.txt";
    let lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();
    let mut count = 0;

    let mut current: HashSet<char> = HashSet::new();
    for line in lines.iter() {
        if line.is_empty() {
            count += current.len();
            current = HashSet::new();
            continue;
        }

        for token in line.chars() {
            current.insert(token);
        }
    }

    count += current.len();

    println!("Day 6 - 1: {}", count);
}

pub fn second() {
    let filename = "day06-01.txt";
    let lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();
    let mut count = 0;

    let mut group: HashSet<char> = HashSet::new();
    let mut first = true;
    for line in lines.iter() {
        if line.is_empty() {
            println!("Finished group");
            count += group.len();
            group = HashSet::new();
            first = true;
            continue;
        }

        if first {
            for token in line.chars() {
                group.insert(token);
            }
            first = false;
            continue;
        }

        let mut current: HashSet<char> = HashSet::new();
        for token in line.chars() {
            current.insert(token);
        }

        let inter = current.intersection(&group);
        let mut tmp: HashSet<char> = HashSet::new();
        for common in inter {
            tmp.insert(*common);
        }
        group.retain(|v| tmp.contains(v));

        println!("after line [{}] group len is {}", line, group.len());
    }

    count += group.len();

    println!("Day 6 - 2: {}", count);
}
