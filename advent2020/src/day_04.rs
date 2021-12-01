use std::collections::HashMap;
use std::collections::HashSet;

lazy_static! {
    static ref REQKEYS: HashSet<&'static str> = {
        let mut h = HashSet::new();
        h.insert("byr");
        h.insert("iyr");
        h.insert("eyr");
        h.insert("hgt");
        h.insert("hcl");
        h.insert("ecl");
        h.insert("pid");
        h
    };
    static ref ALLKEYS: HashSet<&'static str> = {
        let mut h = HashSet::new();
        h.insert("cid");
        h.extend(REQKEYS.iter());
        h
    };
}

pub fn first() {
    let filename = "day04-01.txt";
    let lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();
    let mut valid = 0;

    let mut current: HashSet<&str> = HashSet::new();
    for line in lines.iter() {
        if line.is_empty() {
            // Finished one
            if current == *REQKEYS || current == *ALLKEYS {
                valid += 1;
            }
            current = HashSet::new();
            continue;
        }

        let tokens = line.split(' ');
        for token in tokens {
            let v: Vec<&str> = token.splitn(2, ':').collect();
            let key = v[0];
            current.insert(key);
        }
    }

    if current == *REQKEYS || current == *ALLKEYS {
        valid += 1;
    }

    println!("Day 4 - 1: {}", valid);
}

pub fn second() {
    let filename = "day04-01.txt";
    let lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();

    let mut valid = 0;

    let mut current: HashMap<&str, &str> = HashMap::new();
    for line in lines.iter() {
        if line.is_empty() {
            // Finished one
            if validate(&mut current) {
                valid += 1;
            }
            current = HashMap::new();
            continue;
        }

        let tokens = line.split(' ');
        for token in tokens {
            let v: Vec<&str> = token.splitn(2, ':').collect();
            let key = v[0];
            let value = v[1];
            current.insert(key, value);
        }
    }

    if validate(&mut current) {
        valid += 1;
    }

    println!("Day 4 - 1: {}", valid);
}

fn validate(passport: &mut HashMap<&str, &str>) -> bool {
    if !check_byr(passport.remove("byr")) {
        return false;
    }

    if !check_iyr(passport.remove("iyr")) {
        return false;
    }

    if !check_eyr(passport.remove("eyr")) {
        return false;
    }

    if !check_height(passport.remove("hgt")) {
        return false;
    }

    if !check_hair(passport.remove("hcl")) {
        return false;
    }

    if !check_eye(passport.remove("ecl")) {
        return false;
    }

    if !check_pid(passport.remove("pid")) {
        return false;
    }

    passport.is_empty() || (passport.len() == 1 && passport.contains_key("cid"))
}

fn check_byr(byr: Option<&str>) -> bool {
    if byr.is_none() {
        return false;
    }

    let year = byr.unwrap();

    if year.len() != 4 {
        return false;
    }

    year >= "1920" && year <= "2002"
}

fn check_iyr(iyr: Option<&str>) -> bool {
    if iyr.is_none() {
        return false;
    }

    let year = iyr.unwrap();

    if year.len() != 4 {
        return false;
    }

    year >= "2010" && year <= "2020"
}

fn check_eyr(eyr: Option<&str>) -> bool {
    if eyr.is_none() {
        return false;
    }

    let year = eyr.unwrap();

    if year.len() != 4 {
        return false;
    }

    year >= "2020" && year <= "2030"
}

fn check_height(h: Option<&str>) -> bool {
    if h.is_none() {
        return false;
    }

    let height = h.unwrap();

    if height.ends_with("in") {
        &height[0..2] >= "59" && &height[0..2] <= "76"
    } else if height.ends_with("cm") {
        &height[0..3] >= "150" && &height[0..3] <= "193"
    } else {
        false
    }
}

fn check_hair(h: Option<&str>) -> bool {
    if h.is_none() {
        return false;
    }

    let color = h.unwrap();

    if !color.starts_with('#') {
        return false;
    }

    if color.len() != 7 {
        return false;
    }

    u32::from_str_radix(&color[1..], 16).is_ok()
}

lazy_static! {
    static ref COLORS: HashSet<&'static str> = {
        let mut h = HashSet::new();
        h.insert("amb");
        h.insert("blu");
        h.insert("brn");
        h.insert("gry");
        h.insert("grn");
        h.insert("hzl");
        h.insert("oth");
        h
    };
}

fn check_eye(option: Option<&str>) -> bool {
    if option.is_none() {
        return false;
    }

    COLORS.contains(option.unwrap())
}

fn check_pid(option: Option<&str>) -> bool {
    if option.is_none() {
        return false;
    }

    let pid = option.unwrap();

    if pid.len() != 9 {
        return false;
    }

    pid.chars().all(|c| c.is_digit(10))
}
