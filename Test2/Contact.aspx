<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Test1.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your contact page.</h3>
    <address>
        <br />
        Овчинников Вячеслав Анатольевич<br />
        <abbr title="Phone">P:</abbr>
        +7(91224)92697
    </address>

    <address>
        <strong>Support:</strong>   <a href="mailto:koff4@mail.ru">Support@example.com</a><br />
    </address>
</asp:Content>
