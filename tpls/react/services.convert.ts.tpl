{{- $name := .Name}}
{{- $lowerPluralName := lowerHyphensPlural .Name}}
import {parseInt} from "lodash";

export function convert{{$name}}JSRequest2Go(item: API.{{$name}}): GoAPI.{{$name}} {
    let goItem: GoAPI.{{$name}} = {}
    Object.assign(goItem, item);
    if (item.id) {
        goItem.id = parseInt(item.id);
    }
    return goItem;
}

export function convert{{$name}}sJSReq2Go(items: API.{{$name}}[]): GoAPI.{{$name}}[] {
    let goItems: GoAPI.{{$name}}[] = [];
    for (let i = 0; i < items.length; i++) {
        goItems.push(convert{{$name}}JSReq2Go(items[i]));
    }
    return goItems;
}

export function convert{{$name}}JSReq2Go(item: API.{{$name}}): GoAPI.{{$name}} {
    let goItem: GoAPI.{{$name}} = {}
    Object.assign(goItem, item);
    if (item.children) {
        goItem.children = convertMenusJSReq2Go(item.children);
    }
    if (item.id) {
        goItem.id = parseInt(item.id);
    }
    if (item.parent_id) {
        goItem.parent_id = parseInt(item.parent_id);
    }
    if (item.resources) {
        goItem.resources = convertMenuResourcesJSReq2Go(item.resources)
    }
    return goItem;
}

export function convert{{$name}}GoResponse2JS(item: any): any {
    if (Array.isArray(item)) {
        return convert{{$name}}sGoResp2JS(item);
    } else {
        return convert{{$name}}GoResp2JS(item);
    }
}

export function convert{{$name}}sGoResp2JS(items: GoAPI.Menu[]): API.{{$name}}[] {
    let jsItems: API.{{$name}}[] = [];
    for (let i = 0; i < items.length; i++) {
        jsItems.push(convertMenuGoResp2JS(items[i]));
    }
    return jsItems;
}

export function convert{{$name}}GoResp2JS(item: GoAPI.{{$name}}): API.{{$name}} {
    let jsItem: API.{{$name}} = {}
    Object.assign(jsItem, item);
    if (item.id) {
        jsItem.id = `${item.id}`;
    }
    return jsItem;
}