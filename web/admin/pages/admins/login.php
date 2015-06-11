<article id="content">
	<header>
		<h1>Admin Login</h1>
	</header>
	<section id="loginScreen" class="adminScreen">
		<header>
			<h1>Login Form</h1>
		</header>
		<form id="Login" action="" method="post">
			<fieldset>
				<h2>Admin Login</h2>
				<label for="txtLogin">Username</label>
				<input type="text" name="txtLogin" required autofocus placeholder="username or email" id="txtLogin" <?php if(!empty($_SESSION['errors']['txtLogin'])){ echo "class=\"error\""; } ?> value="<?php if(!empty($_POST['txtLogin'])){ echo $_POST['txtLogin']; } ?>"/>
				<label for="txtPassword">Password</label>
				<input type="password" name="txtPassword" required autofocus placeholder="password" id="txtPassword" <?php if(!empty($_SESSION['errors']['txtPassword'])){ echo "class=\"error\""; } ?> value="<?php if(!empty($_POST['txtPassword']) && !empty($_SESSION['errors']['txtLogin'])){ echo $_POST['txtPassword']; } ?>"/>
				<input type="submit" name="Login" class="loginButton" id="btnLogin" value="Login"/>
				<?php  ?>
			</fieldset>
		</form>
	</sections>
</article>