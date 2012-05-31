{**
@Abstract(Константы для работы с HTML и XHTML)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AHtmlConst;

interface

const
  HTML_TAG_BODY   = 'body';    // Тело документа
  HTML_TAG_HEAD   = 'head';    // Заголовок документа
  HTML_TAG_HTML   = 'html';    // Главный тег
  HTML_TAG_FORM   = 'form';    // Форма
  HTML_TAG_FORM_INPUT = 'input';

const
  HTML_ATTR_ENCTYPE = 'enctype';
  HTML_ATTR_ENCTYPE_APP_FORM = 'application/x-www-form-urlencoded';
  HTML_ATTR_ENCTYPE_TEXT_PLAIN = 'text/plain';

const
  {**
    URL ссылка куда отправлять данные с формы
    Пример
    <html>
    <body>
    <form action="http://demo.url.ru/demo.html">
    </body>
    </html>
  }
  HTML_ATTR_FORM_ACTION = 'action';
  HTML_ATTR_FORM_ENCTYPE = HTML_ATTR_ENCTYPE;
  HTML_ATTR_FORM_ENCTYPE_APP = HTML_ATTR_ENCTYPE_APP_FORM;
  HTML_ATTR_FORM_ENCTYPE_TEXT = HTML_ATTR_ENCTYPE_TEXT_PLAIN;
  HTML_ATTR_FORM_METHOD = 'method';
  HTML_ATTR_FORM_METHOD_GET = 'get';
  HTML_ATTR_FORM_METHOD_POST = 'post';
  HTML_ATTR_FORM_TARGET = 'target';

const
  HTML_ATTR_FORM_INPUT_NAME = 'name';      // Имя элемента ввода
  HTML_ATTR_FORM_INPUT_VALUE = 'value';    // Значение по умолчанию элемента ввода
  HTML_ATTR_FORM_INPUT_TYPE = 'type';      // Тип элемента input в форме
  HTML_ATTR_FORM_INPUT_TYPE_TEXT = 'text'; // Строка ввода тескта
  HTML_ATTR_FORM_INPUT_TYPE_PASSWORD = 'password'; // Строка ввода пароля

const
  HTML_ATTR_FORM_INPUT_TEXT_MAXLENGHT = 'maxlenght'; // Максимальная длина строки при вводе текста

const
  HTML_ATTR_FORM_INPUT_PASSWORD_MAXLENGHT = 'maxlenght'; // Максимальная длина строки при вводе текста

implementation

end.
