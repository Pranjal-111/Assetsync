const{createPool} = require('mysql');
const  dotenv = require('dotenv');
dotenv.config()


const host = process.env.HOST;
const user = process.env.DATABASE_USER;
const database = process.env.DATABASE_NAME;
const password = process.env.PASSWORD;
const port = process.env.DATABASE_PORT;


const pool = createPool({
    host: "sql830.main-hosting.eu",
    user: "u921198258_vivekbudakoti",
    password: "Dev123456",
    database: "u921198258_Assets",
    connectionLimit: 10,
    port: "3306",
 

});

module.exports = pool;





