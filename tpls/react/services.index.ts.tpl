{{- $name := .Name}}
{{- $lowerPluralName := lowerHyphensPlural .Extra.ImportService}}
{{- $lowerModule := lower .Module}}
{{- $lowerName := lower .Name}}
// @ts-ignore
/* eslint-disable */
import { request } from 'umi';
import {responseConvert} from "@/services/response-convert";
import {convert{{$name}}JSRequest2Go, convert{{$name}}GoResponse2JS} from "@/services/{{$lowerModule}}/convert/{{$lowerName}}";

/** Query list GET /api/v1/{{$lowerPluralName}} */
export async function fetch{{$name}}(params: API.PaginationParam, options?: { [key: string]: any }) {
    let response = request<API.ResponseResult<API.{{$name}}[]>>('/api/v1/{{$lowerPluralName}}', {
        method: 'GET',
        params: {
            current: '1',
            pageSize: '10',
            ...params,
        },
        ...(options || {}),
    });
    return responseConvert(response, convert{{$name}}GoResponse2JS);
}

/** Create record POST /api/v1/{{$lowerPluralName}} */
export async function add{{$name}}(body: API.{{$name}}, options?: { [key: string]: any }) {
    let response = request<API.ResponseResult<API.{{$name}}>>('/api/v1/{{$lowerPluralName}}', {
        method: 'POST',
        data: convert{{$name}}JSRequest2Go(body),
        ...(options || {}),
    });
    return responseConvert(response, convert{{$name}}GoResponse2JS);
}

/** Get record by ID GET /api/v1/{{$lowerPluralName}}/${id} */
export async function get{{$name}}(id: string, options?: { [key: string]: any }) {
    let response = request<API.ResponseResult<API.{{$name}}>>(`/api/v1/{{$lowerPluralName}}/${id}`, {
        method: 'GET',
        ...(options || {}),
    });
    return responseConvert(response, convert{{$name}}GoResponse2JS);
}

/** Update record by ID PUT /api/v1/{{$lowerPluralName}}/${id} */
export async function update{{$name}}(id: string, body: API.{{$name}}, options?: { [key: string]: any }) {
    let response = request<API.ResponseResult<any>>(`/api/v1/{{$lowerPluralName}}/${id}`, {
        method: 'PUT',
        data: convert{{$name}}JSRequest2Go(body),
        ...(options || {}),
    });
    return responseConvert(response, convert{{$name}}GoResponse2JS);
}

/** Delete record by ID DELETE /api/v1/{{$lowerPluralName}}/${id} */
export async function del{{$name}}(id: string, options?: { [key: string]: any }) {
    let response = request<API.ResponseResult<any>>(`/api/v1/{{$lowerPluralName}}/${id}`, {
        method: 'DELETE',
        ...(options || {}),
    });
    return responseConvert(response, convert{{$name}}GoResponse2JS);
}
