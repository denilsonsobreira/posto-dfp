program PostoDFP;

uses
  Vcl.Forms,
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {FrmPrincipal},
  uTanque in 'model\uTanque.pas',
  uBomba in 'model\uBomba.pas',
  uFrmBase in 'view\uFrmBase.pas' {FrmBase},
  uFrmBomba in 'view\uFrmBomba.pas' {FrmBomba},
  BombaController in 'controller\BombaController.pas',
  uFrmTanque in 'view\uFrmTanque.pas' {FrmTanque},
  uDmConexao in 'DAO\uDmConexao.pas' {DmConexao: TDataModule},
  TanqueController in 'controller\TanqueController.pas',
  uITanque in 'DAO\interfaces\uITanque.pas',
  uDmTanque in 'DAO\uDmTanque.pas' {DmTanque: TDataModule},
  FDTanque in 'DAO\FDTanque.pas',
  RttiUtils in 'utils\RttiUtils.pas',
  CustomAttributesUtils in 'utils\CustomAttributesUtils.pas',
  uIBomba in 'DAO\interfaces\uIBomba.pas',
  FDBomba in 'DAO\FDBomba.pas',
  uDmBomba in 'DAO\uDmBomba.pas' {DmBomba: TDataModule},
  uFrmConsulta in 'view\uFrmConsulta.pas' {FrmConsulta},
  uFrmValores in 'view\uFrmValores.pas' {FrmValores},
  uDmValores in 'DAO\uDmValores.pas' {DmValores: TDataModule},
  uIValores in 'DAO\interfaces\uIValores.pas',
  uValores in 'model\uValores.pas',
  ValoresController in 'controller\ValoresController.pas',
  FDValores in 'DAO\FDValores.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDmTanque, DmTanque);
  Application.CreateForm(TDmBomba, DmBomba);
  Application.CreateForm(TFrmConsulta, FrmConsulta);
  Application.CreateForm(TFrmValores, FrmValores);
  Application.CreateForm(TDmValores, DmValores);
  Application.Run;
end.
