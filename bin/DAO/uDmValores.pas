unit uDmValores;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmValores = class(TDataModule)
    QryValores: TFDQuery;
    DsValores: TDataSource;
    QryValoresID: TIntegerField;
    QryValoresVALOR_LITRO_GASOLINA: TBCDField;
    QryValoresVALOR_LITRO_OLEO_DIESEL: TBCDField;
    QryValoresVALOR_IMPOSTO: TBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmValores: TDmValores;

implementation

uses
  uDmConexao;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
