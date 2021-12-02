pub fn first() {
    let filename = "data/day02.txt";
    let lines = super::helpers::read_lines(filename);

    let (horizontal, depth) = lines.fold((0, 0), |(horizontal, depth), l| {
        let line = l.unwrap();
        let (instruction, value_s) = line.split_once(' ').unwrap();
        let value = value_s.parse::<i32>().unwrap();

        match instruction {
            "forward" => (horizontal + value, depth),
            "down" => (horizontal, depth + value),
            "up" => (horizontal, depth - value),
            _ => (horizontal, depth),
        }
    });
    println!("Day 02 part 1: {}", horizontal * depth);
}

pub fn second() {
    let filename = "data/day02.txt";
    let lines = super::helpers::read_lines(filename);

    let (horizontal, depth, _aim) = lines.fold((0, 0, 0), |(horizontal, depth, aim), l| {
        let line = l.unwrap();
        let (instruction, value_s) = line.split_once(' ').unwrap();
        let value = value_s.parse::<i32>().unwrap();

        match instruction {
            "forward" => (horizontal + value, depth + value * aim, aim),
            "down" => (horizontal, depth, aim + value),
            "up" => (horizontal, depth, aim - value),
            _ => (horizontal, depth, aim),
        }
    });
    println!("Day 02 part 2: {}", horizontal * depth);
}
