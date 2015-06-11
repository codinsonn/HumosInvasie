<article id="content">
	<header>
		<h1>Add Preset</h1>
	</header>
	<section id="addProductScreen" class="adminScreen">
		<header>
			<h1>Add Preset</h1>
		</header>
		<form id="Login" action="" method="post" enctype="multipart/form-data">
			<fieldset>
				<h2>Add Preset</h2>
				<ul id="thumbList">
					<li id="btnImgUpload" style="cursor:pointer;" onclick="getFiles()"><span>+ Image</span></li>
				</ul>
				<div class="clear"></div>
    			<div style='height: 0px; width:0px; overflow:hidden;'><input id="upfiles" type="file" value="upload images" name="images[]" multiple/></div>
				<label for="lstType">Type</label>
				<select id="lstType" name="lstType">
					<option value="head" <?php if(!empty($_POST['lstType']) && $_POST['lstType'] == "head"){ echo "selected"; } ?>>Head</option>
					<option value="upper_body" <?php if(!empty($_POST['lstType']) && $_POST['lstType'] == "upper_body"){ echo "selected"; } ?>>Upper body</option>
					<option value="lower_body" <?php if(!empty($_POST['lstType']) && $_POST['lstType'] == "lower_body"){ echo "selected"; } ?>>Lower body</option>
				</select>
				<input type="submit" name="submit" id="btnAddPreset" value="Add Image Preset"/>
			</fieldset>
		</form>
	</sections>
</article>
<script>
	var errors = [];
	var btnImgUpload = document.getElementById('btnImgUpload');
	var thumbs = [];
	var maxImages = 1;
	
	function init()
	{
		if (
			window.File && 
			window.FileReader && 
			window.FileList && 
			window.Blob
		) {
			console.log("Full file support");
			document.getElementById('upfiles').addEventListener('change', previewFiles, false);
		}
	}

	function getFiles(){
		document.getElementById("upfiles").click();
	}

	function previewFiles(evt){
		var files = evt.target.files;

		if(thumbs.length >= 1){
			for (var i= 0; thumb = thumbs[i]; i++){
				btnImgUpload.parentNode.removeChild(thumb.el);
			}
			thumbs = [];
		}
 		
		if(files.length <= maxImages){
			var file;
	        for (var i = 0; file = files[i]; i++) {
	            // if the file is not an image, continue
	            if (!file.type.match('image.*')) {
	                continue;
	            }
	 
	            reader = new FileReader();
	            reader.onload = (function (tFile) {
	                return function (evt) {
	                    var thumb = new ImageThumb(evt.target.result);
	                    btnImgUpload.parentNode.insertBefore(thumb.el, btnImgUpload);

	                    thumbs.push(thumb);
	                };
	            }(file));
	            reader.readAsDataURL(file);
	        }
	    }
	}

	function ImageThumb(imgPath){
		this.el = document.createElement('li');
		this.el.style.backgroundImage = "url('"+ imgPath +"')";
		this.selected = false;
	}

	init();
</script>