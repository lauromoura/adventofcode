use std::collections::HashMap;
use std::collections::HashSet;

pub fn first() {
    let filename = "day07-01.txt";
    let lines: Vec<String> = super::helpers::read_lines(filename)
        .into_iter()
        .map(|x| x.unwrap())
        .collect();

    let mut map : HashMap<String, Vec<String> > = HashMap::new();
    
    for line in lines {
        let tokens : Vec<&str> = line.split("contain").collect();
        let bag = tokens[0].to_string().trim().replace(" bags", "");
        let contained = tokens[1];

        println!("bag: [{}]", bag);
        // FIXME REverse map
        // Instead of bag -> children
        // Do bag -> parent.
        // Will make it easier to "bubble up"
        if contained == " no other bags." {
            println!("Bag {} has no other bags inside", bag);
            map.insert(bag.to_string(), Vec::new());
            continue;
        }

        let children = contained.split(", ").map(extract_name);
        map.insert(bag, children.collect());
        // for child in children {
        //     println!("Bag '{}' contains child '{}'", bag, child);
        // }
    }
    
    let mut count = 0;

    // Iterate map
    // FIXME beware shiny gold inside shiny gold
    let mut seen : HashSet<&str> = HashSet::new();
    let mut may_contain : HashSet<&str> = HashSet::new();
    let start_bag = "shiny gold";


    println!("Day 6 - 1: {}", count);
}

fn extract_name(line : &str) -> String {
    let mut initial = line.to_string().trim().replace(" bags", "").replace(".", "").replace(" bag", "");

    let x : Vec<&str> = initial.splitn(2, ' ').collect();


    x[1].to_string()
}