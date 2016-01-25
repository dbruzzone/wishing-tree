exports.sendEmail = function(recipient, subject, message) {
  return { status: 'success', recipient: recipient, subject: subject }; 
};
