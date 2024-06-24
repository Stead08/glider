import gleam/int
import gleam/javascript/array
import gleam/result
import gleam/string
import plinth/browser/document
import plinth/browser/element

pub fn create_carousel(items: array.Array(String)) -> String {
  let items_html =
    items
    |> array.map(item_to_html)
    |> array.fold("", string.append)
  "
  <div class='carousel'>
    <div class='carousel-items'>
    " <> items_html <> "
    </div>
    
    <button class='carousel-button prev'>Previous</button>
    <button class='carousel-button next'>Next</button>
  </div>
  "
}

fn item_to_html(item: String) -> String {
  "
  <div class='carousel-item'>
  " <> item <> "
  </div>
  "
}

pub fn move_prev() {
  // error 用の Element作成
  let element = document.create_element("div")
  let carousel_items =
    document.query_selector(".carousel-items") |> result.unwrap(element)

  let item_width =
    get_offset_width(result.unwrap(
      document.query_selector(".carousel-item"),
      element,
    ))
  let current_transform = get_transform(carousel_items)
  let new_transform =
    "translateX(" <> current_transform + item_width |> int.to_string <> "px)"
  set_transform(carousel_items, new_transform)
}

pub fn move_next() {
  let element = document.create_element("div")
  let carousel_items =
    document.query_selector(".carousel-items") |> result.unwrap(element)
  let item_width =
    get_offset_width(
      document.query_selector(".carousel-item") |> result.unwrap(element),
    )
  let current_transform = get_transform(carousel_items)
  let new_transform =
    "translateX(" <> current_transform - item_width |> int.to_string <> "px)"
  set_transform(carousel_items, new_transform)
}

@external(javascript, "./ffi.js", "getOffsetWidth")
fn get_offset_width(element: element.Element) -> Int

@external(javascript, "./ffi.js", "getTransform")
fn get_transform(element: element.Element) -> Int

@external(javascript, "./ffi.js", "setTransform")
fn set_transform(element: element.Element, transform: String) -> Nil
