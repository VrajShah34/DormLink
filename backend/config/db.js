import mongoose from "mongoose";

const connectDB= async ()=>{

    //ADD IN THE MONGODB URL-------------------------------


    // try{
    //     const conn=await mongoose.connect(process.env.ATLAS_URL);
    //     console.log(`Connected to MongoDB Database ${conn.connection.host}`);
    // }
    // catch(error){
    //     console.log(`Error in MongoDB: ${error}`);
    // }
};

export default connectDB;