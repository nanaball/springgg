<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="utf-8"%>
<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8"/>
</head>
<body>
	<h1>Hello world! - ${sessionScope.test}</h1>
	<h2>model : ${requestScope.modelTest}</h2>
	<h3><a href="doA">doA</a></h3>	
	<h3><a href="doB">doB</a></h3>
	<h3><a href="doC?msg=helloString">doC</a></h3>
	<h3><a href="doD?msg=helloString">doD</a></h3>
	<h3><a href="doD">none-parameter-doD</a></h3>
	
	<hr/>
	
	<a href = "doF">doF GET</a>
	<form action="doF" method="POST">
		<input type="text" name="name" required>
		<input type="number" name="age" required>
		<button>doF post</button> 
	</form>
	
	<hr/>
	
	<h1>상품 정보 입력</h1>
	<form action = "productWrite" method="POST">
		<input type="text" name="name" placeholder="상품이름" required /> <br/>
		<input type="number" name="price" placeholder="상품가격" required />
		<button>PRODUCT WRITE</button>
	</form>
	
	<hr/>
	
	<form action = "productWriteSubmit" method="POST">
		<input type="text" name="name" placeholder="상품이름" required /> <br/>
		<input type="number" name="price" placeholder="상품가격" required />
		<button>PRODUCT WRITE SUBMIT</button>
	</form>
	
	<hr/>
	
	<!-- redirect : 요청 처리후 목록으로 가야하는데 ㄱㅖ산할 필요 없이 화면 요청처리 할 수 있음 -->
	<h3><a href="redirect">redirect</a></h3>
</body>
</html>

