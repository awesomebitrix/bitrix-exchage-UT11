
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	СтрАктуальнойВерсии = ПолучитьСтруктуруАктуальнойВерсииСервер();
	
	Если НЕ ПроверитьАктуальностьТекущегоМодуля(СтрАктуальнойВерсии) тогда
		стрПараметры = Новый Структура;
		стрПараметры.Вставить("ИнформацияООбновлении"	, СтрАктуальнойВерсии);
		стрПараметры.Вставить("ТекущаяВерсияМодуля"		, ПолучитьТекущуюВерсиюМодуля());
		
		ОткрытьФорму("ПланОбмена.Б_ОбменССайтом.Форма.ИнформацииООбновлении", стрПараметры,,,,,, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	Иначе
		ПоказатьПредупреждение(, "У Вас установлена последняя версия модуля 'Интернет-магазин + 1С (" +  ПолучитьТекущуюВерсиюМодуля() + ")",, "Интернет-магазин + 1С");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьСтруктуруАктуальнойВерсииСервер()
	
	ssl = Новый ЗащищенноеСоединениеOpenSSL(
	Неопределено,
	Неопределено); 
	
	Соединение = Новый HTTPСоединение("www.bitrix24.com",,,, ПолучитьПрокси(),,ssl);	
				 
	ИмяФайлаОтвета = ПолучитьИмяВременногоФайла();
	
	Попытка
	
		HTTPОтвет 	= Соединение.Получить("1c_version.php", ИмяФайлаОтвета);
		
	Исключение
		
		Сообщить("Не удалось получить данные с сервера. Проверьте настройки подключения к Интернет.")
		
	КонецПопытки;
	
	СтрАктуальнойВерсии = ПолучитьСтруктуруАктуальнойВерсиейМодуля(ИмяФайлаОтвета);
	
	Возврат СтрАктуальнойВерсии; 
	
КонецФункции


&НаСервере
Функция ПолучитьПрокси()
	
	НастройкаПроксиСервера = ПолучениеФайловИзИнтернета.НастройкиПроксиНаСервере();
	
	Если НастройкаПроксиСервера <> Неопределено
		И НастройкаПроксиСервера["ИспользоватьПрокси"] = Ложь Тогда
		НастройкаПроксиСервера = Неопределено;
	КонецЕсли;
	
	Протокол = "https";
	Прокси = ?(НастройкаПроксиСервера = Неопределено, Неопределено, Б_ОбщиеПроцедурыИФункцииСервер.ПолучитьПрокси(НастройкаПроксиСервера, Протокол));

	Возврат Прокси;

КонецФункции

&НаСервере
Функция ПолучитьСтруктуруАктуальнойВерсиейМодуля(ИмяФайлаОтвета)
	
	ТзнВерсииМодулей = Б_ОбщиеПроцедурыИФункцииСервер.РазобратьФайлСАктуальнымиВерсиямиМодулей(ИмяФайлаОтвета);
	
	//Обработка таблицы с версиями
	лНазваниеМодуля				= "InternetShop1C";                                                                      
	
	лЛокализацияКонфигурации 	= Б_ОбщиеПроцедурыИФункцииСервер.ПолучитьЛокализациюКонфигурации();
	
	лНазваниеКонфигурации 		= Б_ОбщиеПроцедурыИФункцииСервер.ПолучитьСлужебноеНазваниеКонфигурации();
	
	НайденныеСтроки = ТзнВерсииМодулей.НайтиСтроки(Новый Структура("Локализация, НаименованиеКонфигурации, НаименованиеМодуля", лЛокализацияКонфигурации, лНазваниеКонфигурации, лНазваниеМодуля));
	
	СтрСВерсией = Новый Структура;
	СтрСВерсией.Вставить("НаименованиеКонфигурации","");	
	СтрСВерсией.Вставить("РелизКонфигурации","");	
	СтрСВерсией.Вставить("НаименованиеМодуля","");	
	СтрСВерсией.Вставить("ВерсияМодуля","");
	СтрСВерсией.Вставить("Ссылка","");
	СтрСВерсией.Вставить("ВерсияМодуля","");	
	СтрСВерсией.Вставить("История","");	
	
	Если НайденныеСтроки.Количество()>0 тогда
		
		СтрСВерсией.НаименованиеКонфигурации= НайденныеСтроки[0].НаименованиеКонфигурации;
		СтрСВерсией.РелизКонфигурации 		= НайденныеСтроки[0].РелизКонфигурации;
		СтрСВерсией.НаименованиеМодуля 		= НайденныеСтроки[0].НаименованиеМодуля;
		СтрСВерсией.ВерсияМодуля 			= НайденныеСтроки[0].ВерсияМодуля;
		СтрСВерсией.Ссылка 					= НайденныеСтроки[0].Ссылка;
		СтрСВерсией.История 				= Новый ХранилищеЗначения(НайденныеСтроки[0].История);
		
	КонецЕсли;
	
	Возврат СтрСВерсией;
	
КонецФункции

&НаСервере
Функция ПроверитьАктуальностьТекущегоМодуля(СтрАктуальнойВерсии)
	Возврат Б_ОбщиеПроцедурыИФункцииСервер.ПроверитьАктуальностьТекущегоМодуля4(Б_ОбменССайтомСервер.Версия(), СтрАктуальнойВерсии.ВерсияМодуля);
КонецФункции

&НаСервере
Функция ПолучитьТекущуюВерсиюМодуля()
	Возврат Б_ОбменССайтомСервер.Версия();
КонецФункции


