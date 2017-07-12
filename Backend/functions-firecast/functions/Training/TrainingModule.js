
var TrainingObject = require('../Training/TrainingObject');

var TRAINING_ACTION = {
  CREATE : {value: 0, name: "Small", code: "S"}, 
  PROSPECT: {value: 1, name: "Medium", code: "M"}, 
  COMPLETED : {value: 2, name: "Large", code: "L"}
};

function TrainingModule(inAdmin){
console.log("Called from another module........")
    this.newTraining = function(inTrainingDict,callback){
      console.log("Called from newTraining module")
        //Build the Training Object ...
      var trainingObject = new TrainingObject(inTrainingDict)
      
      var rootRef = inAdmin.database().ref("/training_prospect").push({
        "trainingTitle":trainingObject.trainingTitle,
        "trainingCategory":trainingObject.trainingCategory,
         "trainingTitle":trainingObject.trainingTitle,
        "trainingCategory":trainingObject.trainingCategory
      }).then(function(value){
        console.log("Inside createTraining success"+value.key)
        value.update({
          "trainingId":value.key
        })
          callback(value.key,200)
      }).catch(function(error){
        console.log("Inside createTraining error")
            callback(error.message,error.code)
      })
    }
    
}
module.exports = TrainingModule