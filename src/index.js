const express = require("express");

express()
  .get("/", (req, res) => res.status(200).json("Hello World"))
  .listen(8080, () => {
    console.log("Listening on 8080");
  });
