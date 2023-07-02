unit uDmTanque;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmTanque = class(TDataModule)
    QryTanque: TFDQuery;
    QryTanqueID: TIntegerField;
    QryTanqueNOME: TStringField;
    QryTanqueTIPO_COMBUSTIVEL: TIntegerField;
    DsTanque: TDataSource;
    procedure QryTanqueTIPO_COMBUSTIVELGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmTanque: TDmTanque;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDmConexao;

{$R *.dfm}

procedure TDmTanque.QryTanqueTIPO_COMBUSTIVELGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if DisplayText then
    begin
      case QryTanqueTIPO_COMBUSTIVEL.AsInteger of
        0: Text := 'Gasolina';
        1: Text := 'Óleo Diesel';
      end;
    end
  else
    Text := QryTanqueTIPO_COMBUSTIVEL.AsString;
end;

end.
