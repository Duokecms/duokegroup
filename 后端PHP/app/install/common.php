<?php

function sp_execute_sql($db, $sql)
{
    $sql = trim($sql);
    preg_match('/CREATE TABLE .+ `([^ ]*)`/', $sql, $matches);
    if ($matches) {
        $table_name = $matches[1];
        $msg        = "创建数据表{$table_name}";
        try {
            $db->execute($sql);
            return [
                'error'   => 0,
                'message' => $msg . ' 成功！',
                'sql_error' => 0
            ];
        } catch (\PDOException $e) {
            return [
                'error'     => 1,
                'message'   => $msg . ' 失败！',
                'exception' => $e->getMessage(),
                'sql_error' => 0
            ];
        }

    } else {
        try {
            $db->execute($sql);
            return [
                'error'   => 0,
                'message' => 'SQL执行成功!',
                'sql_error' => 0
            ];
        } catch (\PDOException $e) {
            return [
                'error'     => 1,
                'message'   => $e->getMessage(),
                'exception' => $e->getMessage(),
                'sql_error' => 0
            ];
        }
    }
}

function split_sql($file, $tablePre, $charset = 'utf8mb4', $defaultTablePre = 'td_', $defaultCharset = 'utf8mb4')
{
    if (file_exists($file)) {
        //读取SQL文件
        $sql = file_get_contents($file);
        $sql = str_replace("\r", "\n", $sql);
        $sql = str_replace("BEGIN;\n", '', $sql);//兼容 navicat 导出的 insert 语句
        $sql = str_replace("COMMIT;\n", '', $sql);//兼容 navicat 导出的 insert 语句
        $sql = str_replace($defaultCharset, $charset, $sql);
        $sql = trim($sql);
        //替换表前缀
        $sql  = str_replace(" `{$defaultTablePre}", " `{$tablePre}", $sql);
        $sqls = explode(";\n", $sql);
        return $sqls;
    }
    return [];
}