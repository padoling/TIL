# JavaScript Grammar
## JS Array
### slice()
* 배열에서 선택된 부분을 새로운 배열로 만들어 반환함
* Ex)
    ```js
    var fruits = ["Banana", "Orange", "Lemon", "Apple", "Mango"];
    var citrus = fruits.slice(1, 3);
    ```
    Result)
    ```html
    Orange, Lemon
    ```

### concat()
* 여러 개의 배열을 join하기 위해 사용
* 기존 배열을 변경하지 않고 join의 결과로 **새로운 배열을 만들어 반환함**
* Ex)
    ```js
    var hege = ["Cecilie", "Lone"];
    var stale = ["Emil", "Tobias", "Linus"];
    var children = hege.concat(stale);
    ```
    Result)
    ```html
    Cecilie, Lone, Emil, Tobias, Linus
    ```

### map()
* 배열의 모든 요소에 대해 차례대로 주어진 함수를 실행시킴
* 기존 배열을 변경하지 않고 **새로운 배열을 만들어 반환함**
* Ex)
    ```js
    const numbers = [1, 2, 3];
    const doubled = numbers.map(x => x * 2);
    ```
    Result)
    ```html
    2, 4, 6
    ```

## Reference
* <https://www.w3schools.com>
* <https://ko.reactjs.org/tutorial/tutorial.html#showing-the-past-moves>