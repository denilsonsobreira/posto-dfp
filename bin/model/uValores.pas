unit uValores;

interface

uses CustomAttributesUtils;

type TValores = class
  private
    FValorImposto: Currency;
    FValorLitroOleoDiesel: Currency;
    FValorLitroGasolina: Currency;
    FId: Integer;
    procedure SetId(const Value: Integer);
    procedure SetValorImposto(const Value: Currency);
    procedure SetValorLitroGasolina(const Value: Currency);
    procedure SetValorLitroOleoDiesel(const Value: Currency);
  public
    property Id: Integer read FId write SetId;
    [NotNull('O campo Valor do Litro da Gasolina não pode vazio.')]
    property ValorLitroGasolina: Currency read FValorLitroGasolina write SetValorLitroGasolina;
    [NotNull('O campo Valor do Litro do Óleo Diesel não pode vazio.')]
    property ValorLitroOleoDiesel: Currency read FValorLitroOleoDiesel write SetValorLitroOleoDiesel;
    [NotNull('O campo Valor do imposto não pode vazio.')]
    property ValorImposto: Currency read FValorImposto write SetValorImposto;
end;

implementation

{ TValores }

procedure TValores.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TValores.SetValorImposto(const Value: Currency);
begin
  FValorImposto := Value;
end;

procedure TValores.SetValorLitroGasolina(const Value: Currency);
begin
  FValorLitroGasolina := Value;
end;

procedure TValores.SetValorLitroOleoDiesel(const Value: Currency);
begin
  FValorLitroOleoDiesel := Value;
end;

end.
