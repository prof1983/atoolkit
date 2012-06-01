{**
@Abstract(Главная форма программы ArOpenGL)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.10.2006)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AOpenGlForm;

interface

uses
  Classes, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages, OpenGL,
  SysUtils, Variants, Windows,
  AXVrmlOpenGl;

type
  TfmOpenGL3 = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEnabledClose: Boolean;
    FTimer: TTimer;
    // Рисовать звезду
    FIsStar: WordBool;
    FRay1: TPointArray;
    hrc: HGLRC;
    x1: Integer;
    y1: Integer;
    aresx: GLfloat;
    aresy: GLfloat;
    aresz: GLfloat;
    quadObj: GLUquadricObj;
    // Перерисовка окна
    procedure AppOnIdle(Sender: TObject; var Done: Boolean);
    procedure Timer1Timer(Sender: TObject);
  protected
    procedure DoClose(var Action: TCloseAction); override;
    // Срабатывает при создании
    procedure DoCreate; override;
    // Срабатывает при уничтожении
    procedure DoDestroy; override;
  public
    // Инициализировать
    function Initialize: Integer;
  public
    property EnabledClose: Boolean read FEnabledClose write FEnabledClose;
    // Рисовать звезду
    property IsStar: WordBool read FIsStar write FIsStar;
  end;

implementation

{$R *.dfm}

var
  ctrlPoints: array [0..3, 0..7, 0..2] of GLFloat = (
    (
      (-1.5,-1.5,0),
      (-0.4,-2.59,0),
      (0.5,-2,0),
      (1.5,-4.39,0),
      (1.5,-4.39,0),
      (2.5,-2,0),
      (3.5,-2.69,0),
      (4.5,-1.5,0)
    ),
    (
      (-2.49,-0.5,0),
      (-0.5,-0.5,2.5),
      (0.5,-0.8,3),
      (1.5,-0.5,3),
      (1.5,-0.5,3),
      (2.5,-0.8,3),
      (3.5,-0.5,2.5),
      (5.49,-0.5,0)
    ),
    (
      (-2.9,0.5,0),
      (-0.5,0.5,2.5),
      (0.5,0.5,2),
      (1.5,0.5,1.5),
      (1.5,0.5,1.5),
      (2.5,0.5,1.5),
      (3.5,0.5,2.5),
      (5.9,0.5,0)
    ),
    (
      (-1.5,1.5,0),
      (-0.5,2,0),
      (0.5,1.5,0),
      (1.5,0.19,0),
      (1.5,0.09,0),
      (2.5,1.5,0),
      (3.5,2,0),
      (4.5,1.5,0)
    )
  );

{ Private procs }

// Формат пикселя
procedure SetDCPixelFormat(hdc: HDC);
var
  pfd: TPixelFormatDescriptor;
  nPixelFormat: Integer;
begin
  FillChar(pfd, SizeOf (pfd), 0);
  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat (hdc, @pfd);
  SetPixelFormat(hdc, nPixelFormat, @pfd);
end;

{ TfmOpenGL }

procedure TfmOpenGL3.AppOnIdle(Sender: TObject; var Done: Boolean);
begin
  //InvalidateRect(Handle, nil, False);
  Done := False;
end;

procedure TfmOpenGL3.DoClose(var Action: TCloseAction);
begin
  inherited DoClose(Action);
  if not(FEnabledClose) then
    Action := caNone; //caMinimize;
end;

procedure TfmOpenGL3.DoCreate;
begin
  inherited DoCreate;
  FEnabledClose := True;
  //Self.FormStyle := fsStayOnTop;
  BorderStyle := bsSingle; //bsNone; //bsDialog;
  //OnClose := DoClose;
  FIsStar := FindCmdLineSwitch('STAR', ['-','/'], True);

  FTimer := TTimer.Create(Self);
  FTimer.Interval := 10;
  FTimer.OnTimer := Timer1Timer;
  FTimer.Enabled := True;
end;

procedure TfmOpenGL3.DoDestroy;
begin
  if FIsStar then
  begin
    wglDeleteContext(hrc);
  end
  else
  begin
    wglDeleteContext(hrc);
    gluDeleteQuadric(quadObj);
    wglMakeCurrent(0, 0);
    //ReleaseDC(Handle, DC);
    //DeleteDC(DC);
  end;
  inherited DoDestroy;
end;

procedure TfmOpenGL3.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_LEFT then
  begin
    aresx := aresx + 0.1;
    x1 := x1 + 1;
    InvalidateRect(Handle, nil, False);
  end;
  if Key = VK_RIGHT then
  begin
    aresx := aresx - 0.1;
    x1 := x1 - 1;
    InvalidateRect(Handle, nil, False);
  end;
  if Key = VK_UP then
  begin
    aresz := aresz - 0.1;
    y1 := y1 - 1;
    InvalidateRect(Handle, nil, False);
  end;
  if Key = VK_DOWN then
  begin
    aresz := aresz + 0.1;
    y1 := y1 + 1;
    InvalidateRect(Handle, nil, False);
  end;
end;

procedure TfmOpenGL3.FormPaint(Sender: TObject);
begin
  if FIsStar then
  begin
    wglMakeCurrent(Canvas.Handle, hrc);
    glViewPort (0, 0, ClientWidth, ClientHeight);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity;

    gluPerspective(30.0,           // угол видимости в направлении оси Y
                    ClientWidth / ClientHeight, // угол видимости в направлении оси X
                    1.0,            // расстояние от наблюдателя до ближней плоскости отсечения
                    35.0);          // расстояние от наблюдателя до дальней плоскости отсечения

    glMatrixMode (GL_MODELVIEW);
    glLoadIdentity;

    { wglMakeCurrent(Canvas.Handle, hrc);
    glViewPort (0, 0, ClientWidth, ClientHeight);

    glLoadIdentity;
    glFrustum (-1, 1, -1, 1, 3, 10); // задаем перспективу}

    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_COLOR_MATERIAL);

    glClearColor (0.0, 0.0, 0.0, 0.0);

    glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glColor3f(1.0, 0.0, 0.0);


    {glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);}


    glPushMatrix;
    glTranslatef(0.0, 0.0, -4);   // перенос объекта - ось Z

    glRotatef(180, 1, 0.0, 0.0);  // поворот объекта - ось X
    glRotatef(x1, 0, 1.0, 0.0);   // поворот объекта - ось X
    glRotatef(y1, 1.0, 0.0, 0.0); // поворот объекта - ось Y

    glScalef (0.5, 0.5, 0.5);

    PaintPolygonA(FRay1);

    glBegin(GL_POLYGON);
    glNormal3f(0.0, 0.0, 1.0);

    glVertex3f (-0.26, 0.14,1);
    glVertex3f (-1, 1,1);
    glVertex3f (0, 0.44,1);
    glVertex3f (1, 1,1);
    glVertex3f (0.26, 0.14,1);
    glVertex3f (1, 0,1);
    glVertex3f (0.22, -0.18,1);
    glVertex3f (0, -1,1);
    glVertex3f (-0.22, -0.18,1);
    glVertex3f (-1, 0,1);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(-0.5, -0.5, 0.0);
    glVertex3f (-0.26, 0.14,0);
    glVertex3f (-0.26, 0.14,1);
    glVertex3f (-1, 1,1);
    glVertex3f (-1, 1,0);
    glEnd;
    glColor3f(1.0, 0.0, 0.0);

    glBegin (GL_POLYGON);
    glNormal3f(-0.5, 0.5, 0.0);
    glVertex3f (-1, 1,0);
    glVertex3f (-1, 1,1);
    glVertex3f (0, 0.44,1);
    glVertex3f (0, 0.44,0);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(-0.5, 0.5, 0.0);
    glVertex3f (0, 0.44,1);
    glVertex3f (0, 0.44,0);
    glVertex3f (1, 1,0);
    glVertex3f (1, 1,1);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(0.5, -0.5, 0.0);
    glVertex3f (1, 1,0);
    glVertex3f (1, 1,1);
    glVertex3f (0.26, 0.14,1);
    glVertex3f (0.26, 0.14,0);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(0.5, 0.5, 0.0);
    glVertex3f (0.26, 0.14,1);
    glVertex3f (0.26, 0.14,0);
    glVertex3f (1, 0,0);
    glVertex3f (1, 0,1);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(0.5, -0.5, 0.0);
    glVertex3f (1, 0,0);
    glVertex3f (1, 0,1);
    glVertex3f (0.22, -0.18,1);
    glVertex3f (0.22, -0.18,0);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(0.5, -0.5, 0.0);
    glVertex3f (0.22, -0.18,1);
    glVertex3f (0.22, -0.18,0);
    glVertex3f (0, -1,0);
    glVertex3f (0, -1,1);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(-0.5, -0.5, 0.0);
    glVertex3f (0, -1,0);
    glVertex3f (0, -1,1);
    glVertex3f (-0.22, -0.18,1);
    glVertex3f (-0.22, -0.18,0);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(-0.5, -0.5, 0.0);
    glVertex3f (-0.22, -0.18,1);
    glVertex3f (-0.22, -0.18,0);
    glVertex3f (-1, 0,0);
    glVertex3f (-1, 0,1);
    glEnd;

    glBegin (GL_POLYGON);
    glNormal3f(-0.5, 0.5, 0.0);
    glVertex3f (-1, 0,0);
    glVertex3f (-1, 0,1);
    glVertex3f (-0.26, 0.14,1);
    glVertex3f (-0.26, 0.14,0);
    glEnd;

    glPopMatrix;

    SwapBuffers(Canvas.Handle);        // содержимое буфера - на экран
    wglMakeCurrent(0, 0);
  end
  else
  begin
    wglMakeCurrent(Canvas.Handle, hrc);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

    glPushMatrix;
    glScalef (0.4, 0.4, 0.5);
    glTranslatef(aresx, aresy,0);   // перенос объекта - ось Z
    glRotatef (x1, 0, 1.0, 0.0);    // поворот объекта - ось X
    glRotatef (y1, 1.0, 0.0, 0.0);  // поворот объекта - ось Y

    glColor3f(0.5, 0.0, 0.0);
    glEvalMesh2(GL_FILL, 0, 20, 0, 20);
    glRotatef (180, 0, 1.0, 0.0);
    glTranslatef(-3, 0, 0.0);
    glEvalMesh2(GL_FILL, 0, 20, 0, 20);
    glPopMatrix;

    SwapBuffers(Canvas.Handle);        // содержимое буфера - на экран
  end;
end;

procedure TfmOpenGL3.FormResize(Sender: TObject);
const
  amb_dif: array [0..3] of GLfloat = (0.2,0.8,1.0,1.0);
  spec: array [0..3] of GLfloat = (1.0,1.0,1.0,1.0);
begin
  wglMakeCurrent(Canvas.Handle, hrc);
  glViewPort (0, 0, ClientWidth, ClientHeight);
  glMatrixMode (GL_PROJECTION);
  glLoadIdentity;

  gluPerspective(30.0,           // угол видимости в направлении оси Y
                ClientWidth / ClientHeight, // угол видимости в направлении оси X
                1.0,            // расстояние от наблюдателя до ближней плоскости отсечения
                35.0);          // расстояние от наблюдателя до дальней плоскости отсечения

  glMatrixMode (GL_MODELVIEW);
  glLoadIdentity;

  glEnable (GL_LIGHTING);
  glEnable (GL_LIGHT0);
  glEnable (GL_DEPTH_TEST);
  glEnable (GL_COLOR_MATERIAL);
  glEnable(GL_AUTO_NORMAL);

  glClearColor (0.0, 0.0, 0.0, 0.0);

  //glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);
  glTranslatef(0.0, 0.0, -8);   // перенос объекта - ось Z

  glMap2f(GL_MAP2_VERTEX_3, 0, 1, 3, 8, 0, 1, 8*3, 4, @ctrlpoints);
  glEnable(GL_MAP2_VERTEX_3);
  glMapGrid2f(20, 0.0, 1.0, 20, 0.0, 1.0);

  InvalidateRect(Handle, nil, False);
end;

function TfmOpenGL3.Initialize: Integer;

  procedure SetPoint(var P: TGLArrayf3; x, y, z: GLFloat);
  begin
    P[0] := x;
    P[1] := y;
    P[2] := z;
  end;

begin
  Result := 0;
  if FIsStar then
  begin
    SetDCPixelFormat(Canvas.Handle);
    hrc := wglCreateContext(Canvas.Handle);

    // Задаем массив точек для первого луча звезды
    SetLength(FRay1, 10);
    SetPoint(FRay1[0], -0.26, 0.14, 0);
    SetPoint(FRay1[1], -1, 1, 0);
    SetPoint(FRay1[2], 0, 0.44, 0);
    SetPoint(FRay1[3], 1, 1, 0);
    SetPoint(FRay1[4], 0.26, 0.14, 0);
    SetPoint(FRay1[5], 1, 0, 0);
    SetPoint(FRay1[6], 0.22, -0.18, 0);
    SetPoint(FRay1[7], 0, -1, 0);
    SetPoint(FRay1[8], -0.22, -0.18, 0);
    SetPoint(FRay1[9], -1, 0, 0);
  end
  else
  begin
    SetDCPixelFormat(Canvas.Handle);
    hrc := wglCreateContext(Canvas.Handle);
    quadObj := gluNewQuadric;
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_AUTO_NORMAL);
    Application.OnIdle := AppOnIdle;
  end;
end;

procedure TfmOpenGL3.Timer1Timer(Sender: TObject);
begin
  x1 := x1 + 1;
  y1 := y1 + 2;
  InvalidateRect(Handle, nil, False);
end;

procedure TfmOpenGL3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //DoClose;
end;

end.
