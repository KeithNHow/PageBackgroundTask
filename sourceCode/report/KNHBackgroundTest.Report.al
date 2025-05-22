namespace KNHPageBackground;
using Microsoft.Sales.Customer;

report 52000 "KNH Background Test"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = BackgroundTest;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(Number; "No.") { }
            column(Name; "Name") { }
            column(Balance; Balance) { }
        }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Include_Logo; IncludeLogo)
                    {
                        Caption = 'Include Company Logo';
                        ApplicationArea = All;
                        ToolTip = 'IncludeLogo';
                    }
                }
            }
        }
    }
    rendering
    {
        layout(BackgroundTest)
        {
            Type = RDLC;
            LayoutFile = './src/report/rdlc/KNHBackgroundTest.rdl';
        }
    }
    var
        IncludeLogo: Boolean;
}