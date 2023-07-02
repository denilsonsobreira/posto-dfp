unit uDmBomba;

interface

uses
  System.SysUtils, System.Classes, uDmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmBomba = class(TDataModule)
    QryBomba: TFDQuery;
    DsBomba: TDataSource;
    QryBombaID: TIntegerField;
    QryBombaNOME: TStringField;
    QryBombaTANQUE_ID: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmBomba: TDmBomba;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
