import gleam/javascript/array
import gleam/javascript/promise
import glider

pub fn create_carousel(items: array.Array(String)) -> promise.Promise(String) {
  promise.resolve(glider.create_carousel(items))
}

pub fn move_prev() -> promise.Promise(Nil) {
  promise.resolve(glider.move_prev())
}

pub fn move_next() -> promise.Promise(Nil) {
  promise.resolve(glider.move_next())
}
