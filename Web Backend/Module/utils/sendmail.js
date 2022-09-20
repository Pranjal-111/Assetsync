const nodemailer = require("nodemailer");

const sendEmail = async (email, subject, text) => {
  try {
    var transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "sihasset595@gmail.com",
            pass: "kjbzhewujmfmhwyl",
        }
    });

    await transporter.sendMail({
        from: "sihasset595@gmail.com",
        to: email,
        subject: subject,
        text: text
    });
    console.log("email sent sucessfully");
  } catch (error) {
    console.log("email not sent");
    console.log(error);
  }
};

module.exports = sendEmail;
