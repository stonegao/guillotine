require "set"

module Guillotine
  module Keywords
    PARSED_KEYWORDS = Set.new [
      :CASCADE,
      :RESTRICT
    ]
    
    IMPLEMENTED_KEYWORDS = Set.new [
      :AND,
      :ASC,
      :BY,
      :DELAYED,
      :DELETE,
      :DESC,
      :DROP,
      :FROM,
      :INSERT,
      :INTO,
      :IS,
      :NOT,
      :NULL,
      :OR,
      :ORDER,
      :RELEASE,
      :TABLE,
      :WHERE,
      :WITH,
      :SELECT,
    ] unless defined?(IMPLEMENTED_KEYWORDS)
    
    NOT_IMPLEMENTED_KEYWORDS = Set.new [
      :ADD,
      :ALL,
      :ALTER,
      :ANALYZE,
      :AS,
      :ASENSITIVE,
      :BEFORE,
      :BETWEEN,
      :BIGINT,
      :BINARY,
      :BLOB,
      :BOTH,
      :CALL,
      :CASE,
      :CHANGE,
      :CHAR,
      :CHARACTER,
      :CHECK,
      :COLLATE,
      :COLUMN,
      :CONDITION,
      :CONSTRAINT,
      :CONTINUE,
      :CONVERT,
      :CREATE,
      :CROSS,
      :CURRENT_DATE,
      :CURRENT_TIME,
      :CURRENT_TIMESTAMP,
      :CURRENT_USER,
      :CURSOR,
      :DATABASE,
      :DATABASES,
      :DAY_HOUR,
      :DAY_MICROSECOND,
      :DAY_MINUTE,
      :DAY_SECOND,
      :DEC,
      :DECIMAL,
      :DECLARE,
      :DEFAULT,
      :DESCRIBE,
      :DETERMINISTIC,
      :DISTINCT,
      :DISTINCTROW,
      :DIV,
      :DOUBLE,
      :DUAL,
      :EACH,
      :ELSE,
      :ELSEIF,
      :ENCLOSED,
      :ESCAPED,
      :EXISTS,
      :EXIT,
      :EXPLAIN,
      :FALSE,
      :FETCH,
      :FLOAT,
      :FLOAT4,
      :FLOAT8,
      :FOR,
      :FORCE,
      :FOREIGN,
      :FULLTEXT,
      :GRANT,
      :GROUP,
      :HAVING,
      :HIGH_PRIORITY,
      :HOUR_MICROSECOND,
      :HOUR_MINUTE,
      :HOUR_SECOND,
      :IF,
      :IGNORE,
      :IN,
      :INDEX,
      :INFILE,
      :INNER,
      :INOUT,
      :INSENSITIVE,
      :INT,
      :INT1,
      :INT2,
      :INT3,
      :INT4,
      :INT8,
      :INTEGER,
      :INTERVAL,
      :ITERATE,
      :JOIN,
      :KEY,
      :KEYS,
      :KILL,
      :LEADING,
      :LEAVE,
      :LEFT,
      :LIKE,
      :LIMIT,
      :LINES,
      :LOAD,
      :LOCALTIME,
      :LOCALTIMESTAMP,
      :LOCK,
      :LONG,
      :LONGBLOB,
      :LONGTEXT,
      :LOOP,
      :LOW_PRIORITY,
      :MATCH,
      :MEDIUMBLOB,
      :MEDIUMINT,
      :MEDIUMTEXT,
      :MIDDLEINT,
      :MINUTE_MICROSECOND,
      :MINUTE_SECOND,
      :MOD,
      :MODIFIES,
      :NATURAL,
      :NO_WRITE_TO_BINLOG,
      :NUMERIC,
      :ON,
      :OPTIMIZE,
      :OPTION,
      :OPTIONALLY,
      :OUT,
      :OUTER,
      :OUTFILE,
      :PRECISION,
      :PRIMARY,
      :PROCEDURE,
      :PURGE,
      :READ,
      :READS,
      :REAL,
      :REFERENCES,
      :REGEXP,
      :RENAME,
      :REPEAT,
      :REPLACE,
      :REQUIRE,
      :RETURN,
      :REVOKE,
      :RIGHT,
      :RLIKE,
      :SCHEMA,
      :SCHEMAS,
      :SECOND_MICROSECOND,
      :SENSITIVE,
      :SEPARATOR,
      :SET,
      :SHOW,
      :SMALLINT,
      :SONAME,
      :SPATIAL,
      :SPECIFIC,
      :SQL,
      :SQLEXCEPTION,
      :SQLSTATE,
      :SQLWARNING,
      :SQL_BIG_RESULT,
      :SQL_CALC_FOUND_ROWS,
      :SQL_SMALL_RESULT,
      :SSL,
      :STARTING,
      :STRAIGHT_JOIN,
      :TERMINATED,
      :THEN,
      :TINYBLOB,
      :TINYINT,
      :TINYTEXT,
      :TO,
      :TRAILING,
      :TRIGGER,
      :TRUE,
      :UNDO,
      :UNION,
      :UNIQUE,
      :UNLOCK,
      :UNSIGNED,
      :UPDATE,
      :USAGE,
      :USE,
      :USING,
      :UTC_DATE,
      :UTC_TIME,
      :UTC_TIMESTAMP,
      :VALUES,
      :VARBINARY,
      :VARCHAR,
      :VARCHARACTER,
      :VARYING,
      :WHEN,
      :WHILE,
      :WRITE,
      :XOR,
      :YEAR_MONTH,
      :ZEROFILL,
      :ASENSITIVE,
      :CALL,
      :CONDITION,
      :CONNECTION,
      :CONTINUE,
      :CURSOR,
      :DECLARE,
      :DETERMINISTIC,
      :EACH,
      :ELSEIF,
      :EXIT,
      :FETCH,
      :GOTO,
      :INOUT,
      :INSENSITIVE,
      :ITERATE,
      :LABEL,
      :LEAVE,
      :LOOP,
      :MODIFIES,
      :OUT,
      :READS,
      :RELEASE,
      :REPEAT,
      :RETURN,
      :SCHEMA,
      :SCHEMAS,
      :SENSITIVE,
      :SPECIFIC,
      :SQL,
      :SQLEXCEPTION,
      :SQLSTATE,
      :SQLWARNING,
      :TRIGGER,
      :UNDO,
      :UPGRADE,
      :WHILE
    ] unless defined?(SQL_KEYWORDS)

    # Taken from the mysql docs:
    # http://dev.mysql.com/doc/refman/5.0/en/reserved-words.html
    unless defined?(SQL_KEYWORDS)
      SQL_KEYWORDS = PARSED_KEYWORDS.merge(
        IMPLEMENTED_KEYWORDS.merge(NOT_IMPLEMENTED_KEYWORDS)
      )
    end
  end
end
