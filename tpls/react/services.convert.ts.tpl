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

export function convert{{$name}}ListJSReq2Go(items: API.{{$name}}[]): GoAPI.{{$name}}[] {
    let goItems: GoAPI.{{$name}}[] = [];
    for (let i = 0; i < items.length; i++) {
        goItems.push(convert{{$name}}JSReq2Go(items[i]));
    }
    return goItems;
}

export function convert{{$name}}JSReq2Go(item: API.{{$name}}): GoAPI.{{$name}} {
    let goItem: GoAPI.{{$name}} = {}
    Object.assign(goItem, item);
    if (item.id) {
        goItem.id = parseInt(item.id);
    }
    return goItem;
}

export function convert{{$name}}GoResponse2JS(item: any): any {
    if (Array.isArray(item)) {
        return convert{{$name}}ListGoResp2JS(item);
    } else {
        return convert{{$name}}GoResp2JS(item);
    }
}

export function convert{{$name}}ListGoResp2JS(items: GoAPI.Menu[]): API.{{$name}}[] {
    let jsItems: API.{{$name}}[] = [];
    for (let i = 0; i < items.length; i++) {
        jsItems.push(convert{{$name}}GoResp2JS(items[i]));
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