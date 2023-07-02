unit ValoresController;

interface

uses
  uValores, uIValores, Vcl.Forms;

type
  TValoresController = class
    private
      FValoresDAO: IValores;
    public
      constructor create;
      destructor Destroy; override;
      procedure Salvar(Valores: TValores);
      procedure ListaValores(aForm: TForm);
  end;

implementation

uses
  FDValores, RttiUtils;

{ TValoresController }

constructor TValoresController.create;
begin
  FValoresDAO := TFDValores.create;
end;

destructor TValoresController.destroy;
begin

  inherited;
end;

procedure TValoresController.ListaValores(aForm: TForm);
begin
  TRttiUtils.DataSourceToForm(FValoresDAO.ListaValores, aForm);
end;

procedure TValoresController.Salvar(Valores: TValores);
begin
  TRttiUtils.ValidarCampos(Valores);
  FValoresDAO.Salvar(Valores);
end;

end.
