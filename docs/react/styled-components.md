# Styled Components
## Styled Component란?
* CSS-in-JS 라이브러리로, React Component를 CSS를 적용한 component로 만들 수 있음

<br>

## 설치
```bash
npm install styled-components
```

<br>

## 기본 문법
* `styled`를 사용하여 스타일링된 컴포넌트를 생성하고 생성된 컴포넌트를 변수에 저장하여 자유자재로 사용할 수 있음
### HTML 엘리먼트 스타일링
```jsx
const StyledBtn = styled.button`
  // css codes...
`;
```

### React Component tmxkdlffld
```jsx
const StyledBtn = styled(Button)`
  // css codes...
`;
```

<br>

## props에 따른 가변 스타일링
* `props`의 상태나 유무에 따라서 다른 css를 적용할 수 있음
```jsx
// props가 존재하는 경우 해당하는 색깔, 존재하지 않는 경우 gray
const StyledBtn = styled.button`
  color: ${props => props.color || "gray"};
`;
```

<br>

## Reference
* <https://www.daleseo.com/react-styled-components/>
* <https://styled-components.com/docs/api>