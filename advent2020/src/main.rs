#[macro_use]
extern crate lazy_static;

mod day_01;
mod day_02;
mod day_03;
mod day_04;
mod day_05;
mod day_06;
mod day_07;
mod helpers;

fn main() {
    // FIXME Allow selecting the day by argv
    if false {
        day_01::first();
        day_01::second();
        day_02::first();
        day_02::second();
        day_03::first();
        day_03::second();
        day_04::first();
        day_04::second();
        day_05::first();
        day_05::second();
        day_06::first();
        day_06::second();
    }

    day_07::first();
}
