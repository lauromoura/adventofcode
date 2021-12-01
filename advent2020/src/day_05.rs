pub fn first() {
    let filename = "day05-01.txt";
    let mut lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();

    lines.sort();

    let mut max = 0;

    for line in lines {
        let id = get_id(&line);
        if id > max {
            max = id;
        }
    }

    println!("Day 05 - 1: {}", max);
}

fn get_id(code: &str) -> i32 {
    let fb = &code[0..7];
    let lr = &code[7..];
    let mut idx;

    let mut min: i32 = 0;
    let mut max: i32 = 127;
    let mut gap = max - min + 1;

    for y in fb.chars() {
        if y == 'F' {
            max = max - gap / 2;
        } else if y == 'B' {
            min = min + gap / 2;
        }
        gap = max - min + 1;
        println!("{} {} {}", max, min, gap);
    }

    idx = max * 8;

    min = 0;
    max = 7;
    gap = max - min + 1;
    for x in lr.chars() {
        if x == 'L' {
            max = max - gap / 2;
        } else if x == 'R' {
            min = min + gap / 2;
        }
        gap = max - min + 1;
        println!("{} {} {}", max, min, gap);
    }

    idx += max;

    println!("{}-{}", max, min);
    idx
}

pub fn second() {
    let filename = "day05-01.txt";
    let lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();

    let mut ids: Vec<i32> = lines.iter().map(|x| get_id(&x)).collect();

    ids.sort();
    let first = ids.iter();
    let mut second = ids.iter();
    second.next();

    let zipped = first.zip(second);

    for (a, b) in zipped {
        // println!("{} {}", a, b);

        if b - a == 2 {
            println!("Day 05 - 2: {}", b - 1);
            break;
        }
    }
}
