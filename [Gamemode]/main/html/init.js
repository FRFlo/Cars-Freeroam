$(document).ready(function(){
  window.addEventListener('message', function(event) {
    let data = event.data
    if(data.action == 'coords') {
      var node = document.createElement('textarea');
      var selection = document.getSelection();

      node.textContent = event.data.coords;
      document.body.appendChild(node);

      selection.removeAllRanges();
      node.select();
      document.execCommand('copy');

      selection.removeAllRanges();
      document.body.removeChild(node);
    } else if (data.action == 'discord') {
      window.open('https://discord.gg/mpjZRQs', '_blank');
      console.log('OUI');
    }
  });
});
