const {verify} = require("jsonwebtoken");

module.exports = {
    checkToken : (req,res,next)=>{
        let token = req.get("authoriZation");
        if(token){
         token = token.slice(7);
         verify(token,"hjybuhuhuh",(error,decoded)=>{
            if(error){
                res.json({
                    success:0,
                    message:"Invalid Token",
                })
            }
            else{
                next();
            }
         })
        }else{
            res.json({
                success:0,
                message:"Access Denied unauthorised user"
            })
        }
    }
}