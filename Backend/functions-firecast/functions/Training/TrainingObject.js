function TrainingObject(trainingDict) {
  this.trainingId = trainingDict.trainingId
  this.trainingTitle = trainingDict.trainingTitle
  this.trainingCategory = trainingDict.trainingCategory
}

module.exports = TrainingObject
// trainingObject = {
//     trainingId,
//     title,
//     description,
//     minimumSignUpCount
// }