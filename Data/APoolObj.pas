{**
@Author Prof1983 <prof1983@ya.ru>
@Created 04.06.2012
@LastMod 08.06.2012
}
unit APoolObj;

interface

uses
  ABase, ATypes;

type
  TPoolType = (pNone, pUnknown, pNetwork, pFile, pMemory);

type
  TAPoolObject = class
  public
    Name: WideString;
    Title: WideString;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: APascalString): AInt;
  end;
  TAPool = TAPoolObject;

type
  TAMemoryPool = class(TAPool)
  end;

type
  TANetworkPool = class(TAPool)
  end;

type
  TAFilePool = class(TAPool)
  end;

implementation

{ TAPoolObject }

function TAPoolObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
  const AStrMsg: APascalString): AInt;
begin
  Result := -1;
end;

end.
