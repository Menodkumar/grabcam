<?php
if(isset($_POST['image'])){
    $img = $_POST['image'];
    $img = str_replace('data:image/png;base64,', '', $img);
    $img = base64_decode($img);
    file_put_contents("cam_".time().".png", $img);
    file_put_contents("image.txt", "received");
}
?>
