const express = require("express");
const app = express();
const stateRouter = require("./Module/router");
const  dotenv = require('dotenv');
var cors = require('cors');
dotenv.config()
app.use(express.json());


app.use(cors());
app.use("/api",stateRouter);
const port = process.env.PORT;
app.listen(port,()=>{
    console.log(`server is running on port ${port}`);
})
