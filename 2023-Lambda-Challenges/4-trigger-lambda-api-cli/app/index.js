exports.handler = function(event,context,callback){
    console.log("Lambda function successfully created using aws CLI");
    callback(null,"success");
}