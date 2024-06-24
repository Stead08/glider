// getOffsetWidth
export function getOffsetWidth(element) {
  return element.offsetWidth;
}

// get_transform
export function getTransform(element) {
    const transform = window.getComputedStyle(element).transform;
    if (transform === 'none') {
      return 0;
    }
    const matrix = transform.match(/^matrix\((.+)\)$/)[1].split(', ');
    return parseInt(matrix[4], 10);
  }

// set_transform
export function setTransform(element, value) {
  element.style.transform = value;
}