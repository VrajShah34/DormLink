import mongoose from "mongoose";
const announceSchema=new mongoose.Schema({
   
    title:{
        type:String,
        required:true
    },
    description:{
        type:String,
        required:true
    }
});
export default mongoose.model('announce',announceSchema);   