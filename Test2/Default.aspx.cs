using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Test1.Models;

namespace Test1
{
    public partial class _Default : Page
    {
        protected GoodContext db;
        protected Good good;
        //protected decimal vPrice = 0;
        //protected string InvalidDataMessage;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (db == null)
            {
                GoodContext db = new GoodContext();
                Good good = db.Goods.Find(1);
            }
            // txtPrice.Text = Convert.ToString(vPrice);
        }

        protected void ShowError(String msg)
        {
            Response.Write("<script type=\"text/javascript\" language=\"javascript\">alert(\'" + "Server error: " + msg + " !!!" + "\')</script>");

        }

        //Проверка данных формы на сервере
        protected void ChkDataOnServer(out string msg)
        {
            decimal tmpDec;
            string TmpStr;
            msg = "";
            if (txtName.Text == "")
            {
                msg = "Наименование должно быть заполнено";
                return;
            }
            TmpStr = txtPrice.Text; TmpStr = TmpStr.Replace(".", ",");
            if (!decimal.TryParse(TmpStr, out tmpDec))
            {
                msg = "Цена введена неверно";
                return;
            }


        }

        protected void ButtonDelete33_Command(object sender, CommandEventArgs e)
        {
            string sId = (string)e.CommandArgument;
            int iid = Convert.ToInt32(sId);

            if (db == null)
            {
                db = new GoodContext();
            }

            good = this.db.Goods.Find(iid);
            if (good != null)
            {

                db.Goods.Remove(good);
                db.SaveChanges();
                ListView2.DataBind();
                return;
            }
        }

        protected void ButtonInsert_Command(object sender, CommandEventArgs e)
        {
            decimal vPrice = 0;
            if (db == null)
            {
                db = new GoodContext();
            }
            /*
            pnlAddEdit.Visible = true;
            
            PopupHeader.Attributes["Text"] = "Добавить товар";
            txtName.Text = "0.00"; txtName.Focus();
            txtPrice.Text = Convert.ToString(vPrice);
            
            popup.Show();
            */

        }
        protected void ButtonModify_Command(object sender, CommandEventArgs e)
        {

        }
        protected void l_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            string sId, sPrice, sName;
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {

                Button b = (Button)e.Item.FindControl("ButtonModify");
                //конструируем OnClientClick
                System.Data.DataRowView rowView = e.Item.DataItem as System.Data.DataRowView;
                sId = rowView["GoodID"].ToString();
                sName = rowView["Name"].ToString();
                sPrice = rowView["Price"].ToString();
                b.OnClientClick = string.Format("return EditFormData('{0}','{1}','{2}');", sId, sName, sPrice);

            }
        }

        protected void Save(object sender, CommandEventArgs e)
        {
            string err;
            string vName, vPrice;
            decimal dPrice;

            //string sId = (string)e.CommandArgument;
            string sId = goodID.Value;
            //Во избежании 
            if (sId == "-1") return;
            ChkDataOnServer(out err);
            if (err != "")
            {
                ShowError(err);
                return;
            }

            int iid = Convert.ToInt32(sId);
            vName = txtName.Text;
            vPrice = txtPrice.Text.Replace(".", ",");
            dPrice = decimal.Parse(vPrice);

            if (db == null)
            {
                db = new GoodContext();
            }
            if (iid == 0) //Вставка
            {
                this.good = new Good();
            }
            else // Редактирование
            {
                this.good = this.db.Goods.Find(iid);
            }

            this.good.Name = vName;
            this.good.Price = dPrice;

            if (good != null)
            {
                if (iid == 0) //Вставка
                    db.Goods.Add(good);
                db.SaveChanges();
                //if (iid == 0) 
                goodID.Value = "-1";
                //return RedirectToAction("Index"); ;
                UpdatePanel1.Update();

                ListView2.DataBind();
                return;
            }

        }
    }
}
