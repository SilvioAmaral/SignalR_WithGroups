using Microsoft.AspNet.SignalR;
namespace SignalrServer.Hubs
{
    public class Chat : Hub
    {
        //server
        public void Join(string groupName)
        {
            Groups.Add(Context.ConnectionId, groupName);
        }

        public void Send(MyMessage message)
        {
            // Call the addMessage method on all clients            
            //Clients.All.addMessage(message.Msg);
            Clients.Group(message.Group).addMessage(string.Format("Group {0}: {1}", message.Group, message.Msg));
        }
    }


    public class MyMessage
    {
        public string Msg { get; set; }
        public string Group { get; set; }
    }
}